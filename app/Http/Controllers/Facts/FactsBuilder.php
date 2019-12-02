<?php

namespace App\Http\Controllers\Facts;

use DB;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Carbon\Carbon;

class FactsBuilder extends Controller
{
    use PenjualanSparepart;

    public function getNewRecordsPenjualanSparepart() {
        $currentDateTime = Carbon::now();

        DB::beginTransaction();

        try {
            $isThereNewRecords = $this->getNewTransactionsSparepart();

            if (!$isThereNewRecords) {
                DB::rollback();
                return false;
            }

            $this->getNewTransactionsSparepartMonthly();

            $modelExtractionHist = new ExtractionHistory();

            $modelExtractionHist->newRecord($currentDateTime->toDateTimeString(), 'Facts');

            DB::commit();
        } catch(\Exception $e) {
            DB::rollback();

            return $e->getMessage();
        }

        return true;
    }
}
