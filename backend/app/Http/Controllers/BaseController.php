<?php

namespace App\Http\Controllers;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Response as FacadesResponse;
use Symfony\Component\HttpFoundation\Response;

class BaseController
{
    public function sendResponse(string $format = 'json', mixed $data, $statusCode = Response::HTTP_OK)
    {
        if ($format === 'json') {
            return response()->json($data, Response::HTTP_OK);
        } else if ($format === 'csv') {
            $csvFileName = 'movies.csv';
            $headers = array(
                "Content-type" => "text/csv",
                "Content-Disposition" => "attachment; filename=$csvFileName",
                "Pragma" => "no-cache",
                "Cache-Control" => "must-revalidate, post-check=0, pre-check=0",
                "Expires" => "0"
            );
            $handle = fopen('php://output', 'w');
            fputcsv($handle, array_keys($data->toArray()));

            if ($data instanceof Model) {
                fputcsv($handle, array_values($data->toArray()));
            } else {
                //TODO: implementacja kolekcji
            }

            fclose($handle);
            return FacadesResponse::make(rtrim(ob_get_clean()), Response::HTTP_OK, $headers);
        } else {
            return response(["message" => "Invalid format"], Response::HTTP_BAD_REQUEST);
        }
    }
}
