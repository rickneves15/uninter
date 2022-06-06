<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Material
 * 
 * @property int $id_material
 * @property string $material
 * @property string $icone
 * 
 * @property Collection|Card[] $cards
 *
 * @package App\Models
 */
class Material extends Model
{
	protected $table = 'material';
	protected $primaryKey = 'id_material';
	public $timestamps = false;

	protected $fillable = [
		'material',
		'icone'
	];

	public function cards()
	{
		return $this->belongsToMany(Card::class, 'card_material', 'id_material', 'id_card')
					->withPivot('id_card_material');
	}
}
