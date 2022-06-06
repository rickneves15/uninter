<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCardTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('card', function (Blueprint $table) {
            $table->mediumIncrements('id_card');
            $table->unsignedTinyInteger('id_tipo')->index('fk_card_tipo_idx');
            $table->unsignedSmallInteger('id_curso')->nullable()->index('fk_card_curso1_idx');
            $table->unsignedTinyInteger('id_status')->index('fk_card_status1_idx');
            $table->timestamp('dt_registro')->useCurrent();
            $table->year('ano');
            $table->smallInteger('num_aula');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('card');
    }
}
