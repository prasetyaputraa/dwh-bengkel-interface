<?php

namespace App\Models\Transactions;

use Illuminate\Database\Eloquent\Model;

class Service extends Model implements BaseTransaction
{
    use \App\Models\Traits\RecordFinder;

    protected $connection = 'mysql-transaction';

    public function extract($model) {
        return $model
            ->select(
                'id',
                'service_type as nama',
                'vehicle_model as jenis_kendaraan',
                'price as harga'
            );
    }
}
