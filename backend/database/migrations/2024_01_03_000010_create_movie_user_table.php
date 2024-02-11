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
        Schema::create('movie_user', function (Blueprint $table) {
            $table->id();
            $table->string('movie_id', 9);
            $table->unsignedInteger('user_id');
            $table->foreign('movie_id')->references('tconst')->on('movies');
            $table->foreign('user_id')->references('id')->on('users');
            $table->enum('status', ['to_watch', 'viewed']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movie_user');
    }
};
