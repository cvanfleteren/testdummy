interface Customer {
  readonly id: number;
  readonly email: string;
  readonly name: string;
  readonly tags: readonly string[];
}

type OrderStatus = "pending" | "shipped" | "cancelled";

interface Order {
  readonly id: number;
  readonly customerId: number;
  readonly totalCents: number;
  readonly status: OrderStatus;
}

export function totalFor(customer: Customer, orders: readonly Order[]): number {
  return orders
    .filter((order) => order.customerId === customer.id && order.status !== "cancelled")
    .reduce((sum, order) => sum + order.totalCents, 0);
}

export const greet = (customer: Customer): string => `Hello, ${customer.name}!`;
