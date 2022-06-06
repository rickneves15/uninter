<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCardTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('card', function (Blueprint $table) {
            $table->foreign(['id_curso'], 'fk_card_curso1')->references(['id_curso'])->on('curso')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['id_status'], 'fk_card_status1')->references(['id_status'])->on('status')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['id_tipo'], 'fk_card_tipo')->references(['id_tipo'])->on('tipo')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('card', function (Blueprint $table) {
            $table->dropForeign('fk_card_curso1');
            $table->dropForeign('fk_card_status1');
            $table->dropForeign('fk_card_tipo');
        });
    }
}
