<script>
    import { Doughnut, mixins } from "vue-chartjs"

    import { pallete } from "./libs/colors.js"
    
    export default {
        extends: Doughnut,
        mixins: [mixins.reactiveProp],
        props: ['chartData'],

        mounted() {
            this.dataToRender = {
                hoverBackgroundColor: "red",
                hoverBorderWidth: 10,
                labels: this.chartData.map(datum => datum.nama),

                datasets: [
                    {
                        label: "Penjualan dalam jumlah",
                        backgroundColor: this.chartData.map((datum, index) => { return pallete[Object.keys(pallete)[index]]}),
                        data: this.chartData.map(datum => datum.jumlah)
                    },
                    {
                        label: "Penjualan dalam harga",
                        backgroundColor: this.chartData.map((datum, index) => { return pallete[Object.keys(pallete)[index]]}),
                        data: this.chartData.map(datum => datum.total_harga)
                    }
                ]
            };

            this.renderChart(this.dataToRender, {
                maintainAspectRatio: false,
                responsive: true,
                borderWidth: "10px",
                hoverBackgroundColor: "red",
                hoverBorderWidth: "10px"
            });
        },

        watch: {
            dataToRender: function () {
                this.$data._chart.destroy();
                this.renderChart(this.dataToRender, {
                    maintainAspectRatio: false,
                    responsive: true,
                    borderWidth: "10px",
                    hoverBackgroundColor: "red",
                    hoverBorderWidth: "10px"
                });
            }
        }
    }
</script>
