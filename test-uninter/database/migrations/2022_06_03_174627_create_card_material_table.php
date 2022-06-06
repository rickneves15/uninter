<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCardMaterialTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('card_material', function (Blueprint $table) {
            $table->mediumIncrements('id_card_material');
            $table->unsignedMediumInteger('id_card')->index('fk_card_material_card1_idx');
            $table->unsignedTinyInteger('id_material')->index('fk_card_material_material1_idx');

            $table->unique(['id_card', 'id_material'], 'un_card_material');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('card_material');
    }
}
