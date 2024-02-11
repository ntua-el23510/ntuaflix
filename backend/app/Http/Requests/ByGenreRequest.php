<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ByGenreRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    private array $genres = [
        'Short',
        'Animation',
        'Horror',
        'Documentary',
        'Drama',
        'Crime',
        'Musical',
        'Family',
        'Action',
        'Comedy',
        'Fantasy',
        'Western',
        'Sci-Fi',
        'Thriller',
        'Romance',
        'Music',
        'Sport',
        'Adult',
        'Mystery',
        'War',
        'Adventure',
        'Biography',
        'History',
        'News',
    ];

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'qgenre' => ['required', 'string', Rule::in($this->genres)],
            'minrating' => 'required|numeric|min:0',
            'yrFrom' => 'sometimes|digits:4|integer|min:1900|max:'.(date('Y') + 1),
            'yrTo' => 'sometimes|digits:4|integer|min:1900|max:'.(date('Y') + 1),
        ];
    }
}
