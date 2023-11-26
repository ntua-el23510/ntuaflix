<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('crews', function (Blueprint $table) {
            $table->id();
            $table->string('tconst', 9);
            $table->foreign('tconst')->references('tconst')->on('movies');
            $table->string('directors')->nullable();
            $table->string('writers')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('crews');
    }
};
