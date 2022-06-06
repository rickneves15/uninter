<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Professor
 * 
 * @property int $id_professor
 * @property string $nome
 * 
 * @property Collection|Card[] $cards
 *
 * @package App\Models
 */
class Professor extends Model
{
	protected $table = 'professor';
	protected $primaryKey = 'id_professor';
	public $timestamps = false;

	protected $fillable = [
		'nome'
	];

	public function cards()
	{
		return $this->belongsToMany(Card::class, 'card_professor', 'id_professor', 'id_card')
			->withPivot('id_professor');
	}
}
