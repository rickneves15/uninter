<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Curso
 * 
 * @property int $id_curso
 * @property string $curso
 * 
 * @property Collection|Card[] $cards
 *
 * @package App\Models
 */
class Curso extends Model
{
	protected $table = 'curso';
	protected $primaryKey = 'id_curso';
	public $timestamps = false;

	protected $fillable = [
		'curso'
	];

	public function cards()
	{
		return $this->hasMany(Card::class, 'id_curso');
	}
}
