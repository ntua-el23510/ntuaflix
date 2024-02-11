<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PrincipalsTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    public function test_get_principal_by_id(): void
    {
        $principalId = 22;
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/principals/' . $principalId)
            ->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    'id',
                    'tconst',
                    'ordering',
                    'nconst',
                    'category',
                    'job',
                    'characters',
                    'img_url_asset',
                    'movie'
                ]
            ]);
    }
}
