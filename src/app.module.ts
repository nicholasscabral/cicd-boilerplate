import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    // TypeOrmModule.forRoot({
    //   type: 'mysql',
    //   host: 'mysql',
    //   port: 3307,
    //   username: 'root',
    //   password: 'root',
    //   database: 'test',
    // }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
