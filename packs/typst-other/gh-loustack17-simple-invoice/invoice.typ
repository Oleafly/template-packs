#import "module/data.typ": invoice_data
#import "module/model.typ": build_invoice_view
#import "module/layout.typ": render_invoice

#render_invoice(build_invoice_view(invoice_data))
