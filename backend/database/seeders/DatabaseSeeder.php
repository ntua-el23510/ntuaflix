<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Crew;
use App\Models\Movie;
use App\Models\MovieAka;
use App\Models\Person;
use App\Models\Principal;
use App\Models\Rating;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->seedNameBasics(); //people
        $this->seedTitleBasics();
        $this->seedTitleAkas();
        $this->seedCrews();
        $this->seedRatings();
        $this->seedPrincipals();
    }

    private function seedNameBasics(): void
    {
        $csvData = fopen(base_path('database/seeders/data/truncated_name.basics.tsv'), 'r');

        $transRow = true;
        while (($data = fgetcsv($csvData, 0, "\t")) !== false) {
            if (! $transRow) {
                Person::updateOrCreate([
                    'nconst' => $data[0],
                ], [
                    'primaryName' => $data[1],
                    'birthYear' => $data[2] ? $data[2] : null,
                    'deathYear' => $data[3] ? $data[3] : null,
                    'primaryProfession' => $data[4],
                    'knownForTitles' => $data[5],
                    'img_url_asset' => $data[6],
                ]);
            }
            $transRow = false;
        }
        fclose($csvData);
    }

    private function seedTitleBasics(): void
    {
        $csvData = fopen(base_path('database/seeders/data/truncated_title.basics.tsv'), 'r');

        $transRow = true;
        while (($data = fgetcsv($csvData, 0, "\t")) !== false) {
            if (! $transRow) {
                Movie::updateOrCreate([
                    'tconst' => $data[0],
                ], [
                    'titleType' => $data[1],
                    'primaryTitle' => $data[2],
                    'originalTitle' => $data[3],
                    'isAdult' => $data[4],
                    'startYear' => $data[5],
                    'endYear' => $data[6] ? $data[6] : null,
                    'runtimeMinutes' => $data[7] ? $data[7] : null,
                    'genres' => $data[8] ? $data[8] : null,
                    'img_url_asset' => $data[9] ? $data[9] : null,
                ]);
            }
            $transRow = false;
        }
        fclose($csvData);
    }

    private function seedTitleAkas(): void
    {
        $csvData = fopen(base_path('database/seeders/data/truncated_title.akas.tsv'), 'r');

        $transRow = true;
        while (($data = fgetcsv($csvData, 0, "\t")) !== false) {
            if (! $transRow) {
                MovieAka::updateOrCreate([
                    'titleId' => $data[0],
                    'ordering' => $data[1],
                ], [
                    'title' => $data[2],
                    'region' => $data[3] ? $data[3] : null,
                    'language' => $data[4] ? $data[4] : null,
                    'types' => $data[5] ? $data[5] : null,
                    'attributes' => $data[6] ? $data[6] : null,
                    'isOriginalTitle' => $data[7],
                ]);
            }
            $transRow = false;
        }
        fclose($csvData);
    }

    private function seedCrews(): void
    {
        $csvData = fopen(base_path('database/seeders/data/truncated_title.crew.tsv'), 'r');

        $transRow = true;
        while (($data = fgetcsv($csvData, 0, "\t")) !== false) {
            if (! $transRow) {
                Crew::updateOrCreate([
                    'tconst' => $data[0],
                ], [
                    'directors' => $data[1] ? $data[1] : null,
                    'writers' => $data[2] ? $data[2] : null,

                ]);
            }
            $transRow = false;
        }
        fclose($csvData);
    }

    private function seedRatings(): void
    {
        $csvData = fopen(base_path('database/seeders/data/truncated_title.ratings.tsv'), 'r');

        $transRow = true;
        while (($data = fgetcsv($csvData, 0, "\t")) !== false) {
            if (! $transRow) {
                Rating::updateOrCreate([
                    'tconst' => $data[0],
                ], [
                    'averageRating' => $data[1],
                    'numVotes' => $data[2],

                ]);
            }
            $transRow = false;
        }
        fclose($csvData);
    }

    private function seedPrincipals(): void
    {
        $csvData = fopen(base_path('database/seeders/data/truncated_title.principals.tsv'), 'r');

        $transRow = true;
        while (($data = fgetcsv($csvData, 0, "\t")) !== false) {
            if (! $transRow) {
                Principal::updateOrCreate([
                    'tconst' => $data[0],
                    'nconst' => $data[2],
                ], [
                    'ordering' => $data[1],
                    'category' => $data[3],
                    'job' => $data[4] ? $data[4] : null,
                    'characters' => $data[5] ? $data[5] : null,
                    'img_url_asset' => $data[6] ? $data[6] : null,

                ]);
            }
            $transRow = false;
        }
        fclose($csvData);
    }
}
