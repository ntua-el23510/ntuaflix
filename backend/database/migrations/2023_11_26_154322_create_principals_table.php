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
        Schema::create('principals', function (Blueprint $table) {
            $table->id();
            $table->string('tconst', 9);
            $table->foreign('tconst')->references('tconst')->on('movies');
            $table->unsignedInteger('ordering');
            $table->string('nconst', 10);
            $table->foreign('nconst')->references('nconst')->on('people');
            $table->string('category');
            $table->string('job')->nullable();
            $table->string('characters')->nullable();
            $table->string('img_url_asset')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('principals');
    }
};
