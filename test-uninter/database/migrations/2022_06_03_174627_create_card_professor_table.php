<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCardProfessorTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('card_professor', function (Blueprint $table) {
            $table->mediumIncrements('id_card_professor');
            $table->unsignedMediumInteger('id_card')->index('fk_card_professor_card1_idx');
            $table->unsignedSmallInteger('id_professor')->index('fk_card_professor_professor1_idx');

            $table->unique(['id_card', 'id_professor'], 'un_card_professor');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('card_professor');
    }
}
