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
        Schema::create('movie_akas', function (Blueprint $table) {
            $table->id();
            $table->string('titleId', 9);
            $table->foreign('titleId')->references('tconst')->on('movies');
            $table->unsignedInteger('ordering');
            $table->string('title');
            $table->string('region')->nullable();
            $table->string('language')->nullable();
            $table->string('types')->nullable();
            $table->string('attributes')->nullable();
            $table->boolean('isOriginalTitle');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movie_akas');
    }
};
