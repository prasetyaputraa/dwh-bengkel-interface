<?php

namespace App\Models\Transactions;

use Illuminate\Database\Eloquent\Model;

class Sparepart extends Model implements BaseTransaction
{
    use \App\Models\Traits\RecordFinder;

    protected $connection = 'mysql-transaction';

    public function extract($model) {
        return $model
            ->select(
                'id',
                'sparepart_name as nama',
                'sparepart_type as jenis_kendaraan',
                'price as harga'
            );
    }
}
