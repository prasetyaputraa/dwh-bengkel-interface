<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ExtractionHistory extends Model
{
    protected $table = 'extraction_history';

    public function newRecord($datetime, $extraction_type) {
        $this->insert(['created_at' => $datetime, 'extraction_type' => $extraction_type]);
    }
}
