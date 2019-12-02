<?php

namespace App\Http\Controllers\Facts;

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

use App\Models\Facts\SparepartPembelian;
use App\Models\Facts\SparepartPembelianBulanan;

use App\Models\ExtractionHistory;

trait PembelianSparepart
{
}
