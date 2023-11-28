<?php

use App\Http\Api\TitleObject;
use Illuminate\Support\Str;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Collection;

if (!function_exists('stringToObject')) {
    /**
     * This function uploads files to the filesystem of your choice
     * @param \Illuminate\Http\UploadedFile $file The File to Upload
     * @param string|null $filename The file name
     * @param string|null $folder A specific folder where the file will be stored
     * @param string $disk Your preferred Storage location(s3,public,gcs etc)
     */

    function UploadFile(UploadedFile $file, $folder = null, $filename = null, $disk = 's3')
    {
        $name = is_null($filename) ? $filename : Str::random(10);

        return $file->storeAs(
            $folder,
            $name . "." . $file->getClientOriginalExtension(),
            $disk
        );
    }

    function stringToObject(string $input, string $key): array
    {
        $inputToArray = explode(',', $input);
        for ($i = 0; $i < count($inputToArray); $i++) {
            $genreTitle = $inputToArray[$i];
            $result[] = array($key => $genreTitle);
        }
        return $result;
    }
}
if (!function_exists('objectToString')) {
    function objectToString(array $input): array
    {
        $result = [];
        foreach ($input as $key => $item) {
            if ($item instanceof Collection) {
                $item = $item->toArray();
            }
            if (is_string($item)) {
                $result[$key] = $item;
            } else if (is_array($item)) {
                if (hasNestedArray($item)) {
                    $csvString = "";
                    foreach ($item as $genre) {
                        foreach ($genre as $key => $value) {
                            $csvString .= $key . ',' . $value . '|';
                        }
                    }
                    // Usunięcie ostatniego znaku '|'
                    $result[$key] = rtrim($csvString, '|');
                } else {
                    $csvString = "";
                    foreach ($item as $key => $value) {
                        $csvString .= $key . ',' . $value . '|';
                    }
                    $result[$key] = rtrim($csvString, '|');
                }
            } else if (is_null($item)) {
                $result[$key] = null;
            }
        }
        return $result;
    }

    function hasNestedArray($array)
    {
        return count(array_filter($array, 'is_array')) > 0;
    }
}
