<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Status
 * 
 * @property int $id_status
 * @property string $status
 * @property string $cor
 * 
 * @property Collection|Card[] $cards
 * @property Collection|CardMovimentacao[] $card_movimentacaos
 *
 * @package App\Models
 */
class Status extends Model
{
	protected $table = 'status';
	protected $primaryKey = 'id_status';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_status' => 'int'
	];

	protected $fillable = [
		'status',
		'cor'
	];

	public function cards()
	{
		return $this->hasMany(Card::class, 'id_status');
	}

	public function card_movimentacaos()
	{
		return $this->hasMany(CardMovimentacao::class, 'id_status');
	}
}
