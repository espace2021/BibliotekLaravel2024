<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Livre extends Model
{
    use HasFactory;
    protected $fillable = [
        'isbn',
        'titre',
        'annedition',
        'prix',
        'qtestock',
        'couverture'
    ];
    public function editeur()
    {
        return $this->belongsTo(Editeur::class);
    }
    
    public function specialite()
    {
        return $this->belongsTo(Specialite::class);
    }
    
    public function auteurs()
    {
        return $this->belongsToMany(Auteur::class);
    }
}
