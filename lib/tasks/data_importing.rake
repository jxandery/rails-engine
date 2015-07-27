require 'csv'

task :read_file => :environment do
  model_csvs=
    [[Customer, 'customers'],
     [Merchant,'merchants'],
     [Item, 'items'],
     [Invoice, 'invoices'],
     [Transaction, 'transactions'],
     [InvoiceItem, 'invoice_items']
  ]

    model_csvs.each do |model, csv|
      file = "lib/assets/#{csv}.csv"
      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        model.find_or_create_by(row.to_hash)
      end
      puts "#{model} data imported"
    end
end

