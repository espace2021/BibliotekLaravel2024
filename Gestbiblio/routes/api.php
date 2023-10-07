<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuteurController;

use App\Http\Controllers\SpecialiteController;

use App\Http\Controllers\EditeurController;

use App\Http\Controllers\LivreController;

Route::middleware('api')->group(function () {
    Route::resource('auteurs', AuteurController::class);
});

Route::middleware('api')->group(function () {
    Route::resource('editeurs', EditeurController::class);
});

Route::middleware('api')->group(function () {
    Route::resource('livres', LivreController::class);
});