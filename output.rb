class Output
  def self.write_to_file(invoices, file)
    open(file, 'w') do |f|
      f.puts "Begin of invoice"
      f.puts "***********************\n\n"

      invoices.each do |invoice|
        f.puts "#{decorate_invoice(invoice)}\n"
      end

      f.puts "\n***********************"
      f.puts "End of invoice"
    end
  end

  private

  def self.decorate_invoice(invoice)
    invoice_title = "#{invoice.order.quantity} #{invoice.order.code} $#{invoice.total_price || ''}\n"

    "#{invoice_title}#{invoice_body(invoice)}"
  end

  def self.invoice_body(invoice)
    return "We are sorry. We cannot serve your order." unless invoice.shipping_packs

    body = invoice.shipping_packs
      .reject { |shipping_pack| shipping_pack.count == 0 }
      .map do |shipping_pack|
        "      #{shipping_pack.count} x #{shipping_pack.pack.number_of_unit} $#{shipping_pack.pack.price}"
      end

   body.join("\n")
  end
end