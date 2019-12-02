<?php

namespace App\Models\Traits;

use App\Models\ExtractionHistory;

trait RecordFinder {
    public function afterLastExtract($extractionType) {

        $modelExtractHist = new ExtractionHistory();

        $lastExtractDate = $modelExtractHist->where('extraction_type', '=', $extractionType)->latest()->first()->created_at;

        return $this->where('created_at', '>=', $lastExtractDate->toDateTimeString())->where('extraction_type', '=', $extractionType);
    }
}
