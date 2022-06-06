<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class CardMaterial
 * 
 * @property int $id_card_material
 * @property int $id_card
 * @property int $id_material
 * 
 * @property Card $card
 * @property Material $material
 *
 * @package App\Models
 */
class CardMaterial extends Model
{
	protected $table = 'card_material';
	protected $primaryKey = 'id_card_material';
	public $timestamps = false;

	protected $casts = [
		'id_card' => 'int',
		'id_material' => 'int'
	];

	protected $fillable = [
		'id_card',
		'id_material'
	];

	public function card()
	{
		return $this->belongsTo(Card::class, 'id_card');
	}

	public function material()
	{
		return $this->belongsTo(Material::class, 'id_material');
	}
}
