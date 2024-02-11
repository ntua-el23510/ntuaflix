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
        Schema::create('movies', function (Blueprint $table) {
            $table->string('tconst', 9)->primary();
            $table->string('titleType');
            $table->string('primaryTitle');
            $table->string('originalTitle');
            $table->boolean('isAdult');
            $table->year('startYear');
            $table->year('endYear')->nullable();
            $table->unsignedInteger('runtimeMinutes')->nullable();
            $table->string('genres')->nullable();
            $table->string('img_url_asset')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movies');
    }
};
