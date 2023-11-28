<?php

namespace App\Http\Controllers;

use App\Http\Api\TitleObject;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Response as FacadesResponse;
use Symfony\Component\HttpFoundation\Response;

class BaseController
{
    public function sendResponse(string $format = 'json', mixed $data, $statusCode = Response::HTTP_OK)
    {
        if ($format === 'json') {
            if ($data instanceof TitleObject) {
                $objectToArray = $data->toArray();
            } else {
                $objectToArray = array_map(function ($item) {
                    return $item->toArray();
                }, $data);
            }
            return response()->json($objectToArray, Response::HTTP_OK);
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

            if ($data instanceof TitleObject) {
                $objectToArray = $data->toArray();
                $data = objectToString($objectToArray);
                fputcsv($handle, array_keys($data));
                fputcsv($handle, array_values($data));
            } else {
                $data = array_map(function ($item) {
                    return objectToString($item->toArray());
                }, $data);
                fputcsv($handle, array_keys($data[0]));
                foreach ($data as $d) {
                    fputcsv($handle, array_values($d));
                }
            }

            fclose($handle);
            return FacadesResponse::make(rtrim(ob_get_clean()), Response::HTTP_OK, $headers);
        } else {
            return response(["message" => "Invalid format"], Response::HTTP_BAD_REQUEST);
        }
    }
}
