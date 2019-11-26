<?php

namespace App\Http\Controllers\Facts;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use DB;

use App\Models\Transactions\Customer;
use App\Models\Transactions\Employee;
use App\Models\Transactions\Service;
use App\Models\Transactions\Sparepart;
use App\Models\Transactions\Supplier;
use App\Models\Transactions\Transaction;

use App\Models\Dimensions\Jasa as DimensionService;
use App\Models\Dimensions\Pegawai as DimensionEmployee;
use App\Models\Dimensions\Pelanggan as DimensionCustomer;
use App\Models\Dimensions\Sparepart as DimensionSparepart;
use App\Models\Dimensions\Supplier as DimensionSupplier;

use App\Models\Facts\SparepartPenjualan;

class PenjualanSparepart extends Controller
{
    public function loadAll() {
        $results = DB::connection('mysql-transaction')
            ->table('sparepart_transactions')
            ->join('transactions', 'sparepart_transactions.transaction_id', '=', 'transactions.id')
            ->select(
                DB::raw('transactions.customer_id as id_pelanggan'),
                DB::raw('transactions.mechanical_id as id_mekanik'),
                DB::raw('transactions.operator_id as id_operator'),
                DB::raw('sparepart_transactions.sparepart_id as id_sparepart'),
                DB::raw('transactions.date as tanggal'),
                DB::raw('sparepart_transactions.qty as jumlah'),
                DB::raw('sparepart_transactions.sub_price as total_harga')
            )
            ->get();

        $results = collect($results)->map(function ($result) { return (array) $result; })->toArray();

        $modelSpPenjualan = new SparepartPenjualan();

        $modelSpPenjualan->insert($results);

        return true;
    }
}
