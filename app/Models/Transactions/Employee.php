<?php

namespace App\Models\Transactions;

use Illuminate\Database\Eloquent\Model;

class Employee extends Model implements BaseTransaction
{
    use \App\Models\Traits\RecordFinder;

    protected $connection = 'mysql-transaction';

    public function extract($model) {
        return $model
            ->select(
                'id',
                'name as nama',
                'phone as no_telepon',
                'address as alamat',
                'role as jabatan'
            );
    }
}
