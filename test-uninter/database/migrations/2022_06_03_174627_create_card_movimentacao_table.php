<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCardMovimentacaoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('card_movimentacao', function (Blueprint $table) {
            $table->mediumIncrements('id_card_movimentacao');
            $table->unsignedMediumInteger('id_card')->index('fk_card_movimentacao_card1_idx');
            $table->unsignedTinyInteger('id_status')->index('fk_card_movimentacao_status1_idx');
            $table->timestamp('dt_registro')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('card_movimentacao');
    }
}
