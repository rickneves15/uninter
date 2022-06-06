<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\CardController;
use App\Http\Controllers\CursoController;
use App\Http\Controllers\ProfessorController;
use App\Http\Controllers\TipoController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/cards/{curso}/{num_aula}/{prefessor}/{ordenar}/{ordenar_sentido}', [CardController::class, 'index']);
Route::get('/card/{id}', [CardController::class, 'show']);
Route::get('/card/next/{id}', [CardController::class, 'next']);
Route::get('/card/previous/{id}', [CardController::class, 'previous']);
Route::get('/curso', [CursoController::class, 'index']);
Route::get('/professor', [ProfessorController::class, 'index']);
Route::get('/tipo', [TipoController::class, 'index']);
