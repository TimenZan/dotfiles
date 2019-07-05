import { Observable } from 'rxjs';
/**
 *
 * only keep the lastest source observable value until the inner observable complete,
 * then trigger the lastest source observable value
 *
 * @param isAbandon - is abandon inner observable value when there is newer source observable value
 *
 */
export declare function waitMap<T, K>(fn: (res: T) => Observable<K>, isAbandon?: boolean): (obs: Observable<T>) => Observable<K>;
