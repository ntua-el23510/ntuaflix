<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class RequiredEnpointsTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    public function test_search_by_genre(): void
    {
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/bygenre?qgenre=Short&minrating=6&yrFrom=1994&yrTo=1997&format=json')
            ->assertStatus(200)
            ->assertJsonStructure([
                '*' => [
                    'titleID',
                    'type',
                    'originalTitle',
                    'titlePoster',
                    'startYear',
                    'endYear',
                    'genres' => [
                        '*' => [
                            'genreTitle'
                        ]
                    ],
                    'titleAkas' => [
                        '*' => [
                            'akaTitle',
                            'regionAbbrev'
                        ]
                    ],
                    'principals' => [
                        '*' => [
                            'nameID',
                            'name',
                            'category'
                        ]
                    ],
                    'rating' => [
                        'avRating',
                        'nVotes'
                    ]
                ]
            ]);
    }

    public function test_get_by_nameID()
    {
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/name/nm0794211?format=json')
            ->assertStatus(200)
            ->assertJsonStructure([
                'nameID',
                'name',
                'namePoster',
                'birthYr',
                'deathYr',
                'profession',
                'nameTitles' =>
                [
                    '*' => [
                        'titleID',
                        'category'
                    ]
                ],
            ]);
    }

    public function test_search_by_name()
    {
        $response = $this->get('http://kni.prz.edu.pl:47474/api/ntuaflix_api/searchname?nqueryObject=James')
            ->assertStatus(200)
            ->assertJsonStructure([
                '*' => [
                    'nameID',
                    'name',
                    'namePoster',
                    'birthYr',
                    'deathYr',
                    'profession',
                    'nameTitles' =>
                    [
                        '*' => [
                            'titleID',
                            'category'
                        ]
                    ],
                ]

            ]);
    }
}
