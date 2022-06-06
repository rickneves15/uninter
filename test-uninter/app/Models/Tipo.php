<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Tipo
 * 
 * @property int $id_tipo
 * @property string $tipo
 * 
 * @property Collection|Card[] $cards
 *
 * @package App\Models
 */
class Tipo extends Model
{
	protected $table = 'tipo';
	protected $primaryKey = 'id_tipo';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_tipo' => 'int'
	];

	protected $fillable = [
		'tipo'
	];

	public function cards()
	{
		return $this->hasMany(Card::class, 'id_tipo');
	}
}
