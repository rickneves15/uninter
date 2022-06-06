<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class CardMovimentacao
 * 
 * @property int $id_card_movimentacao
 * @property int $id_card
 * @property int $id_status
 * @property Carbon $dt_registro
 * 
 * @property Card $card
 * @property Status $status
 *
 * @package App\Models
 */
class CardMovimentacao extends Model
{
	protected $table = 'card_movimentacao';
	protected $primaryKey = 'id_card_movimentacao';
	public $timestamps = false;

	protected $casts = [
		'id_card' => 'int',
		'id_status' => 'int'
	];

	protected $fillable = [
		'id_card',
		'id_status',
		'dt_registro'
	];

	public function card()
	{
		return $this->belongsTo(Card::class, 'id_card');
	}

	public function status()
	{
		return $this->belongsTo(Status::class, 'id_status');
	}
}
