<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Card
 * 
 * @property int $id_card
 * @property int $id_tipo
 * @property int|null $id_curso
 * @property int $id_status
 * @property Carbon $dt_registro
 * @property Carbon $ano
 * @property int $num_aula
 * 
 * @property Curso|null $curso
 * @property Status $status
 * @property Tipo $tipo
 * @property Collection|Material[] $materials
 * @property Collection|CardMovimentacao[] $card_movimentacaos
 * @property Collection|Professor[] $professors
 *
 * @package App\Models
 */
class Card extends Model
{
	protected $table = 'card';
	protected $primaryKey = 'id_card';
	public $timestamps = false;

	protected $casts = [
		'id_tipo' => 'int',
		'id_curso' => 'int',
		'id_status' => 'int',
		'num_aula' => 'int',
	];

	protected $dateFormat = 'Y-m-d H:i:s';
	protected $fillable = [
		'id_tipo',
		'id_curso',
		'id_status',
		'dt_registro',
		'ano',
		'num_aula'
	];

	protected $appends = ['data', 'hora'];

	public function curso()
	{
		return $this->belongsTo(Curso::class, 'id_curso');
	}

	public function status()
	{
		return $this->belongsTo(Status::class, 'id_status');
	}

	public function tipo()
	{
		return $this->belongsTo(Tipo::class, 'id_tipo');
	}

	public function materiais()
	{
		return $this->belongsToMany(Material::class, 'card_material', 'id_card', 'id_material')
			->withPivot('id_card_material');
	}

	public function card_movimentacaos()
	{
		return $this->hasMany(CardMovimentacao::class, 'id_card');
	}

	public function professores()
	{
		return $this->belongsToMany(Professor::class, 'card_professor', 'id_card', 'id_professor')
			->withPivot('id_card');
	}

	public function getDataAttribute()
	{
		return Carbon::parse($this->dt_registro)->format('d/m/Y');
	}

	public function getHoraAttribute()
	{
		return Carbon::parse($this->dt_registro)->format('H:i');
	}
}
