<?php

namespace App\Http\Controllers;

use App\Models\Livre;
use Illuminate\Http\Request;

class LivreController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $livres = Livre::with('editeurs','specialites','auteurs')->get()->toArray();
        return array_reverse($livres);  

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $livre = new Livre([
            'isbn' => $request->input('isbn'),
            'titre' => $request->input('titre'),
            'annedition' => $request->input('annedition'),
            'prix' => $request->input('prix'),
            'qtestock' => $request->input('qtestock'),
            'couverture' => $request->input('couverture')

            ]);
        $livre->save();

        return response()->json('Livre créé !');

    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $livre= Livre::find($id);
        return response()->json($livre);

    }

    /**
     * Update the specified resource in storage.
     */
    public function update($id, Request $request)
    {
        $livre = Livre::find($id);
        $livre->update($request->all());

        return response()->json($livre);

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $livre = Livre::find($id);
        $livre->delete();

        return response()->json(['message' => 'Livre deleted successfully']);

    }
}
