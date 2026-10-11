#let invoice_data = (
  issuer: (
    logo_path: "../assets/logo.png",
    name: "ABC Company",
    contact: "Lou Chang",
    url: "loustack.dev",
    phone: "+1-123-456-7890",
    email: "aaa@abc.com",
  ),
  meta: (
    title: "INVOICE",
    number: "InvoiceNumber001",
    date_label: "DATE",
    date_override: none,
    due_label: "DUE",
    due_value: "UPON RECEIPT OF SERVICES",
  ),
  bill_to: (
    label: "BILL TO",
    customer: "XYZ Inc.",
  ),
  table: (
    headers: (
      service: "Service",
      rate: "Rate",
      quantity: "Quantity",
      discount: "Discount",
      payment_due: "Payment due",
    ),
    detail_marker: "•",
    services: (
      (
        description: "Software development services (24 hr)",
        rate: 100,
        rate_unit: "hr",
        quantity: 24,
        discount: 0,
        details: (
          (text: "AWS Infrastructure Provisioning (EC2, VPC, IAM, S3, SG)", quantity: 12),
          (text: "CI/CD Pipeline Setup (GitHub Actions)", quantity: 12),
        ),
      ),
    ),
  ),
  summary: (
    total_label: "Total",
    payment_label: "Payment received",
    payment_amount: 0,
    balance_label: "Balance due",
  ),
  payment: (
    title: "Payment instructions",
    transfer_label: "E-transfer",
    transfer_value: "aaa@abc.com",
    paypal_label: "Paypal",
    paypal_text: "paypal.me/YOURPAYPAL",
    paypal_url: "https://paypal.me/YOURPAYPAL",
  ),
)
