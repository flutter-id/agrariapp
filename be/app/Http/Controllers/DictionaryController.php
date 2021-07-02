<?php

namespace App\Http\Controllers;

use App\Models\Dictionary;
use Illuminate\Http\Request;

class DictionaryController extends Controller
{
    public function index($search = null)
    {
        if($search){
            $data = Dictionary::where('term','like','%'.$search.'%')->get();
        }else{
            $data = Dictionary::all();
        }
        return response()->json([
            'success'   => true,
            'message'   => 'List of Data',
            'data'      => $data
        ],200);
    }
}
