<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class CardProfessor
 * 
 * @property int $id_card_professor
 * @property int $id_card
 * @property int $id_professor
 * 
 * @property Card $card
 * @property Professor $professor
 *
 * @package App\Models
 */
class CardProfessor extends Model
{
	protected $table = 'card_professor';
	protected $primaryKey = 'id_card_professor';
	public $timestamps = false;

	protected $casts = [
		'id_card' => 'int',
		'id_professor' => 'int'
	];

	protected $fillable = [
		'id_card',
		'id_professor'
	];

	public function card()
	{
		return $this->belongsTo(Card::class, 'id_card');
	}

	public function professor()
	{
		return $this->belongsTo(Professor::class, 'id_professor');
	}
}
