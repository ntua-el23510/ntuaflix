<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PeopleTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    public function test_get_person_by_id(): void
    {
        $personId = 'nm0066941';
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/people/' . $personId)
            ->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    'nconst',
                    'primaryName',
                    'birthYear',
                    'birthYear',
                    'deathYear',
                    'primaryProfession',
                    'knownForTitles',
                    'img_url_asset'
                ]
            ]);
    }
}
