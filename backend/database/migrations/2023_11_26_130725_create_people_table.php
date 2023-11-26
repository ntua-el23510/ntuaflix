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
        Schema::create('people', function (Blueprint $table) {
            $table->string('nconst', 10)->primary();
            $table->string('primaryName');
            $table->year('birthYear')->nullable();
            $table->year('deathYear')->nullable();
            $table->string('primaryProfession');
            $table->string('knownForTitles');
            $table->string('img_url_asset');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('people');
    }
};
