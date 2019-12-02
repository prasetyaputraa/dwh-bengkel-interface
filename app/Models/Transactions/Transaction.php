<?php

namespace App\Models\Transactions;

use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use \App\Models\Traits\RecordFinder;

    protected $connection = 'mysql-transaction';
}
