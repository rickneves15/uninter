<?php

namespace App\Http\Controllers;

use App\Models\Card;
use App\Models\CardMovimentacao;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CardController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($curso, $num_aula, $prefessor, $ordenar, $ordenar_sentido)
    {
        $query = Card::with([
            'curso',
            'status',
            'tipo',
            'card_movimentacaos',
            'materiais',
            'professores',
        ]);

        if ($curso != "all") {
            $query->where('card.id_curso', $curso);
        }
        if ($num_aula != "all") {
            $query->where('card.num_aula', $num_aula);
        }

        if ($prefessor != "all") {
            $query->join('card_professores', function ($join) use ($prefessor) {
                $join->on('card_professores.id_card', '=', 'card.id_card')
                    ->where('card_professores.id_card_professor', '=', $prefessor);
            });
        }

        if ($ordenar == "professor") {
            $query->orderBy('card_professores.id_card_professor', $ordenar_sentido);
        } else {
            $query->orderBy($ordenar, $ordenar_sentido);
        }

        $cards = $query->get();
        $idsCards = $query->pluck('id_card');

        $numeroDeAulas = Card::select('num_aula')
            ->orderBy('num_aula', 'asc')
            ->groupBy('num_aula')
            ->get();

        $quantidadeStatus =  Card::selectRaw('id_status, count(*) as quantidade_status')
            ->whereIn('id_card', $idsCards)
            ->orderBy('id_status', 'asc')
            ->groupBy('id_status')
            ->having('quantidade_status', '>=', 1)
            ->get();

        return response()->json([
            'cards' => $cards,
            'numero_aulas' => $numeroDeAulas,
            'quantidade_status' => $quantidadeStatus
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function show($cardId)
    {

        $card = Card::with([
            'curso',
            'status',
            'tipo',
            'card_movimentacaos',
            'materiais',
            'professores',
        ])
            ->where('id_card', $cardId)
            ->get();
        return response()->json($card);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function next($cardId)
    {
        $card = Card::with([
            'curso',
            'status',
            'tipo',
            'card_movimentacaos',
            'materiais',
            'professores',
        ])
            ->where('id_card', $cardId)
            ->first();

        $to = Carbon::createFromFormat('Y-m-d H:i:s', Carbon::parse($card['dt_registro'])->format('Y-m-d H:i:s'));
        $from = Carbon::createFromFormat('Y-m-d H:i:s', Carbon::now()->format('Y-m-d H:i:s'));
        $diffInMinutes  = $from->diffInSeconds($to);

        if (count($card['professores']) == 0) {
            return response()->json(["message" => "O card não contém professores adicionados"], 422);
        }

        if ($card['id_status'] == 1) {
            $card['id_status'] = 2;
        } else if ($card['id_status'] == 2 && count($card['professores']) > 0) {
            $card['id_status'] = 3;
        } else if ($card['id_status'] == 3 && $diffInMinutes <= 60) {
            return response()->json(["message" => "Necessário esperar 1 minuto para realizar a ação"], 422);
        } else {
            $card['id_status'] = 4;
        }

        $card_movimentacao = new CardMovimentacao();
        $card_movimentacao->id_card = $card['id_card'];
        $card_movimentacao->id_status = $card['id_status'];
        $card_movimentacao->dt_registro = Carbon::now()->format('Y-m-d H:i:s');
        $card_movimentacao->save();

        DB::update('UPDATE card SET id_status = ? WHERE id_card = ?', [$card['id_status'], $card['id_card']]);

        return response()->json(['card' => $card]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function previous($cardId)
    {
        $cardMovimentacao = CardMovimentacao::where('id_card', $cardId)
            ->orderBy('dt_registro', 'desc')
            ->limit(1)
            ->skip(1)
            ->first();


        DB::update('UPDATE card SET id_status = ? WHERE id_card = ?', [$cardMovimentacao['id_status'], $cardMovimentacao['id_card']]);

        $card = Card::with([
            'curso',
            'status',
            'tipo',
            'card_movimentacaos',
            'materiais',
            'professores',
        ])
            ->where('id_card', $cardMovimentacao['id_card'])
            ->first();
        return response()->json(['card' => $card]);
    }
}
