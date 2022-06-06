<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCardMaterialTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('card_material', function (Blueprint $table) {
            $table->foreign(['id_card'], 'fk_card_material_card1')->references(['id_card'])->on('card')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['id_material'], 'fk_card_material_material1')->references(['id_material'])->on('material')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('card_material', function (Blueprint $table) {
            $table->dropForeign('fk_card_material_card1');
            $table->dropForeign('fk_card_material_material1');
        });
    }
}
