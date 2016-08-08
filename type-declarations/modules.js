/* eslint-disable no-empty */
import type { Browser } from './types';
declare module 'bluebird' {}
declare module 'chai' {
  declare function use(plugin: any): void
  declare function expect(value: any): Object
}
declare module 'chai-as-promised' {}
declare module 'nightmare' {
  declare var exports: {
    (): Browser,
  }
}
