// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);



document.addEventListener('turbo:load', () => {
    console.log('Hello from application.js')
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: JSON.parse(ctx.canvas.dataset.labels),
      datasets: [{
        label: 'Monthly Expenses',
        data: JSON.parse(ctx.canvas.dataset.data),
      }]
    },
    });
  })

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('year-select').addEventListener('change', function() {
    // Trigger form submission when year is selected
    document.getElementById('year-form').submit();
  });
});