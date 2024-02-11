<?php

namespace Tests\Feature;

use App\Models\Movie;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class MovieTest extends TestCase
{
    public function test_get_movie_by_id()
    {
        $movieId = "tt0000929";
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/movies/' . $movieId, ['Accept' => 'application/json']);
        $response
            ->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    'tconst',
                    'titleType',
                    'primaryTitle',
                    'originalTitle',
                    'isAdult',
                    'startYear',
                    'endYear',
                    'runtimeMinutes',
                    'genres',
                    'img_url_asset'
                ]
            ]);
    }

    public function test_get_media_list()
    {
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/movies/get-started-movies')
            ->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    '*' => [
                        'tconst',
                        'titleType',
                        'primaryTitle',
                        'originalTitle',
                        'isAdult',
                        'startYear',
                        'endYear',
                        'runtimeMinutes',
                        'genres',
                        'img_url_asset'
                    ]
                ]
            ]);
    }

    public function test_searchbar()
    {
        $param1 = 'Kate';
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/searchbar?searchPart=' . $param1)
            ->assertStatus(200)
            ->assertJsonStructure([
                'movies',
                'people',
                'principals'
            ]);
    }
}
