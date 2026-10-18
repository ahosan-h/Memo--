import 'dotenv/config';

import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';

import { PrismaClient } from '../../generated/prisma/client';

import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  private static pool: Pool;

  constructor() {
    const databaseUrl = process.env.DATABASE_URL;

    if (!databaseUrl) {
      throw new Error('DATABASE_URL is not defined');
    }

    if (!PrismaService.pool) {
      PrismaService.pool = new Pool({
        connectionString: databaseUrl,
        max: 8,
        idleTimeoutMillis: 30_000,
        connectionTimeoutMillis: 5_000,
      });
    }

    const adapter = new PrismaPg(PrismaService.pool);

    super({ adapter });
  }

  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();

    // The pool is shared, so close it only during
    // application shutdown, not during normal requests.
    await PrismaService.pool?.end();
  }
}
