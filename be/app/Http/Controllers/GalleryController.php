<?php

namespace App\Http\Controllers;

use App\Models\Gallery;
use Illuminate\Http\Request;

class GalleryController extends Controller
{
    public function index()
    {
        $data = Gallery::all();
        return response()->json([
            'success'   => true,
            'message'   => 'List of Data',
            'data'      => $data
        ],200);
    }
}
